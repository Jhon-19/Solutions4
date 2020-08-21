function act = getAct(p1, p2, d)
%得到act等级
a1 = 0.5;
a2 = 0.5;
k = 0.2;
act = a1*(p1-p2)^2+a2*d-k;
end