function price = getPrice(A, B, s, n)
%计算新定价
p1 = A(4, 1)*s.^3+A(3, 1)*s.^2+A(2,1)*s+A(1, 1);
p2 = B(3, 1)*n.^2+B(2, 1)*n+B(1, 1);
price = p1*0.69+p2*0.31;
end