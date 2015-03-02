%Put in TF of guralp
SampleRate = 20;
TMax = 1000;
SampleNumber = TMax*SampleRate;

Time = linspace(0,TMax, SampleNumber);

y1 = timeseries(wgn(SampleNumber,1,0),Time);
zref = [0 0]';
%pref = [-11.78*10^-3+1i*11.78*10^-3 -11.78E-3-1i*11.78*10^-3];
pref = .7*[-1+1j -1-1j]';
kref = 1;
[bref,aref] = zp2tf(zref,pref,kref);
figure(1)
bode(bref, aref)

figure(2)
y2 = filter(bref,  aref,y1.Data);
plot(y1, 'g')
hold on
plot(y2,'-.')
hold off
figure(3)
[psdy1, f1] = pwelch(y1.Data,200,100,200,SampleRate);
%loglog(f1, psdy1, 'g');
hold on
[psdy2, f2] = pwelch(y2,hanning(8192),8192/2,8192,SampleRate,'power');
plot(f2, 10*log10(psdy2));
hold off