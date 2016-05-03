function [v_e, v_n]=bf_envhilb(v_x)



% if v_x is a set of oscillatory signals (a 2-D vector : 1-st dimension = time), this function creates the envelope that corresponds to all the positive maxima of v_x
% the method uses a hilbert transform
% requires hilbert function

s_test=0;
if (size(v_x,2)>size(v_x,1))
   v_x=v_x';
   s_test=1;
end;   

v_h=hilbert(v_x);
v_e=abs(v_h);
v_fd=find(v_e==0);
v_n=v_x./v_e;
v_n(v_fd)=0;
if (s_test)
   v_n=v_n';
   v_e=v_e';
end;