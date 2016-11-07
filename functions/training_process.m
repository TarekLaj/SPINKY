function [varargout] = training_process(data,fs,detection_mode,varargin)
%This function allows to compute, depending on detection_mode value,
%optimal threshold for Kcomplex and / or spindle detection 
%**********************************************************
%Inputs:
%**********************************************************
%1. sig=EEG training data 
%2. fs: sampling freaquency (Hz)
%3. epoch_length: EEG epoch duration (sec) 
%4. detection mode:string variable defining events to detect, this variable must be either:
%                'spindles':  to detect only spindles 
%                'kcomplex':  to detect only kcomplex
%                'both': to detect spindles and kcomplex
%5. varargin depending on detection mode varargin must be : 
%                   sp_thresh,sp_train_score if detection mode = 'spindles'
%                   kp_thresh,kp_train_score if detection mode= 'kcomplex' 
%                   sp_thresh,sp_train_score, kp_thresh,kp_train_score if detection mode = 'both'
% where: 
%     sp_thresh is the threshold range for spindles detection
%     sp_train_score is the  visual score of training data for spindles detection 
%     kp_thresh is the threshold range for kcomplex detection
%     kp_train_score  is the  visual score of training data for kcomlex detection 
%************************************************************
%Important: 
%************************************************************
%   1. These vaules must be defined /loaded previously in the script 
%   2. They must be put in the correct order 
%%**********************************************************
%Output:
%**********************************************************
%varargout: depending on detection mode value this variable contains:
%"sp_optimal_thresh" and/or "kp_optimal_thresh" which are the optimal thresholds values computed in the training process 
%
% Example:
% [op_thr_sp,op_thr_kp] = training_process(train_data,fs,detection_mode,sp_thresh,sp_train_score,kp_thresh,kp_train_score);



%TQWT decomposition

%data=data_epoching(sig,epoch_length); % divide EEG data into "epoch_length" segments (the function output is a cell array)
display('signal decomposition....')
for j=1:length(data)
    [transit{j},oscil{j}]=signal_decomposition(data{j},fs);
end

%training and threshold choice
display('Optimal threshold selection...')
switch detection_mode
    case 'spindles' 
    [sp_optimal_thresh] = sp_train(oscil,varargin{1},fs,varargin{2},varargin{3});
    varargout{1}=sp_optimal_thresh;
    fprintf('The optimal threshold for spindles detection is %i uVolt^2',sp_optimal_thresh);
    case 'kcomplex'
    [kp_optimal_thresh] = kp_train(transit,varargin{1},fs,varargin{2},varargin{3});
    varargout{1}=kp_optimal_thresh;
    fprintf('The optimal threshold for kcomplex detection is %i uVolt',kp_optimal_thresh);
     case 'both'
    [sp_optimal_thresh] = sp_train(oscil,varargin{1},fs,varargin{2},varargin{5});
    [kp_optimal_thresh] = kp_train(transit,varargin{3},fs,varargin{4},varargin{5});
    varargout{1}=sp_optimal_thresh;
    varargout{2}=kp_optimal_thresh;
     fprintf('The optimal threshold for spindles detection is %i uVolt^2 \n',sp_optimal_thresh);
     fprintf('The optimal threshold for kcomplex detection is %i  uVolt \n',kp_optimal_thresh);
end
end

