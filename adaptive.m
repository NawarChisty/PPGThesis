function [ output ] = adaptive( original, signal )

lms = dsp.LMSFilter(5, 'StepSize', 0.5, 'Method', 'Normalized LMS', 'WeightsOutputPort', true);
%mumax = maxstep(lms,signal)
output = step(lms, original, signal);

end
