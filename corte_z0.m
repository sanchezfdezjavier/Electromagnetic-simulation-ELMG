% ELMG
% M7 ESTRUCTURA DE CORRIENTE EN UN CILINDRO

%Preparación para la ejecución
close all
clear

%Constantes
resolucion = 40;
R = 1;
z0 = 2.5;
rho = 1;
axis = linspace(-5.*R, 5.*R, resolucion);

%Variables de iteración
v = 1;
w = 1;

%Almacén de valores
Bx_values_z0 = zeros(40,40);
By_values_z0 = Bx_values_z0;
% Bz_values = Bx_values;


%Cálculo de todas las componentes de campo magnético B: Bx, By y Bz.
for x = axis
    
    for y = axis
        Bx = @(rhop, phip, zp) (((sin(pi .* rhop / 2) .* cos(3 .* pi .* zp./5)) .* (cos(phip) .* (-zp))) ./ ...
            ((x-rhop.* cos(phip)).^2 + (y - rhop.* sin(phip)).^2 + (-zp).^2).^(3/2)) .* rhop;
        By = @(rhop, phip, zp) ((sin(pi.*rhop/2).*cos(3.*pi.*zp./5)).*(sin(phip).*(-zp)).*rhop) ./...
            (((x-rhop.*cos(phip)).^2 + (y-rhop.*sin(phip)).^2 + (-zp).^2).^(3/2));
%         Bz = @(rhop, phip, zp) (sin(pi .* rhop ./ 2) .* cos(3 .* pi .* zp / 5)) ...
%             .* ((-sin(phip) .* (y - rhop .* sin(phip)) - cos(phip) .* (x - rhop .* cos(phip))) ./ ...
%             (((x - rhop .* cos(phip)).^2 + (y - rhop .* sin(phip)).^2 + (-zp).^2)).^(3/2));
       
        Bx_values_z0(v, w) = integral3(Bx, 0, 1, 0,2.*pi, 0, 1);
        By_values_z0(v, w) = integral3(By, 0, 1, 0,2.* pi, 0, 1);
%         Bz_values_z0(v, w) = integral3(Bz, 0.0001, 1, 0.0001, 2 * pi, -x0, x0);
%         
        w = w + 1;
    end
    
    v = v + 1;
    w = 1;
end

% Representación del campo magnético B, en el plano z = 0
figure(2);
[x, y] = meshgrid(axis, axis);
quiver(x, y, Bx_values_z0, By_values_z0, 'LineWidth', 1);
title('Campo magnético en el plano z = 0');
xlabel('x'); %Revisar que estos label no estén cambiados
ylabel('y');

