% ELMG
% M7 ESTRUCTURA DE CORRIENTE EN UN CILINDRO

%Preparación para la ejecución
close all
clear

%Constantes
z0 = 2.5;
rho = 1;
axis = linspace(-5, 5, 10);

%Variables de iteración
v = 1;
w = 1;

%Almacén de valores
Bx_values = zeros(5);
By_values = Bx_values;
Bz_values = Bx_values;

%Cálculo del campo B, en el plano x = 0;
for z = axis

    for y = axis
%           Bx = @(rhop, phip, zp) (((sin(pi .* rhop / 2) .* cos(3 .* pi .* zp)) .* (cos(phip) .* (z - zp))) ./ ...
%                (1 + (-rhop .* cos(phip)).^2 + (y - rhop .* sin(phip)).^2 + (z - zp).^2)) .* rhop;
          By = @(rhop, phip, zp) ((sin(pi.*rhop/2).*cos(3.*pi.*zp)).*(sin(phip).*(z-zp)).*rhop) ./...
                (((-rhop.*cos(phip)).^2 + (y-rhop.*sin(phip)).^2 + (z-zp).^2).^(3/2));
          Bz = @(rhop, phip, zp) (sin(pi .* rhop ./ 2) .* cos(3 .* pi .* zp / 5)) ...
                    .* ((-sin(phip) .* (y - rhop .* sin(phip)) - cos(phip) .* (-rhop .* cos(phip))) ./ ...
                    (((-rhop .* cos(phip)).^2 + (y - rhop .* sin(phip)).^2 + (z - zp).^2)).^(3/2))

%         Bx_values(v, w) = integral3(Bx, 0, 1, 0, 2 * pi, -z0, z0);
        By_values(v, w) = integral3(By, 0.0001, 1, 0.0001, 2 * pi, -z0, z0);
        Bz_values(v, w) = integral3(Bz, 0.0001, 1, 0.0001, 2 * pi, -z0, z0);

        w = w + 1;
    end

    v = v + 1;
    w = 1;
end

%Representación del campo magnético en el plano x = 0
figure
[y, z] = meshgrid(axis, axis);
quiver(y, z, By_values, Bz_values);
title('Campo magnético en el plano x = 0');
xlabel('y'); %Revisar que estos label no estén cambiados
ylabel('z');

