function d = getDistance(A, B)
d = 111.199*((((A(1, 2)-B(1, 2))*180/pi)^2+((A(1, 1)-B(1, 1))*180/pi)^2)*(cos((B(1, 2)+B(1, 1))*180/pi/2))^2)/2;
end