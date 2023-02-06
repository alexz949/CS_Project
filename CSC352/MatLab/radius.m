prompt = "radius: "
r = input(prompt)
r_1 = input(prompt)


A = 4*pi*(r*1000+r_1/100)^2 - 4*pi*(r*1000)^2
A_2 = 4*pi*(2*(r*1000) + r_1/100)*(r_1/100)
A_3 = 8*pi*r*1000*(r_1/100)

formatSpec = "The first one %f, the second one %f, the third one %f.";
fprintf(formatSpec, A, A_2,A_3)