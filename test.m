

%Limpieza
close all
clear

%Constantes
z0 = 2.5;
axis=linspace(-3,3,40);
%Variables de iteración
v = 1;
w = 1;
%Almacén de valores
Bx = zeros(40);
Bx_values = Bx;
for z = axis
    for y = axis
        Bx = @(rhop,phip,zp)(((sin(pi.*rhop/2).*cos(3.*pi.*zp)).*(cos(phip).*(z-zp))) ./ (1+(-rhop.*cos(phip)).^2 + (y-rhop.*sin(phip)).^2 + (z-zp).^2)).*rhop;
        Bx_values(v,w) = integral3(Bx, 0,1, 0,2*pi, -z0,z0);
        w=w+1;
    end
    v= v+1;
    w=1;
end

