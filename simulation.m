% ELMG
% M7 ESTRUCTURA DE CORRIENTE EN UN CILINDRO

%Preparación para la ejecución
close all
clear

%Constantes
resolucion = 100;
R = 1;
z0 = 2.5;
rho = 1;
axis = linspace(-8.*R, 8.*R, resolucion);

%Variables de iteración
v = 1;
w = 1;

%Almacén de valores
Bx_values = zeros(10);
By_values = Bx_values;
Bz_values = Bx_values;


%Cálculo de todas las componentes de campo magnético B: Bx, By y Bz.
for z = axis
    
    for y = axis
        Bx = @(rhop, phip, zp) (((sin(pi .* rhop / 2) .* cos(3 .* pi .* zp./5)) .* (cos(phip) .* (z - zp))) ./ ...
            ((-rhop.* cos(phip)).^2 + (y - rhop.* sin(phip)).^2 + (z - zp).^2).^(3/2)) .* rhop;
        By = @(rhop, phip, zp) ((sin(pi.*rhop/2).*cos(3.*pi.*zp./5)).*(sin(phip).*(z-zp)).*rhop) ./...
            (((-rhop.*cos(phip)).^2 + (y-rhop.*sin(phip)).^2 + (z-zp).^2).^(3/2));
        Bz = @(rhop, phip, zp) (sin(pi .* rhop ./ 2) .* cos(3 .* pi .* zp / 5)) ...
            .* ((-sin(phip) .* (y - rhop .* sin(phip)) - cos(phip) .* (-rhop .* cos(phip))) ./ ...
            (((-rhop .* cos(phip)).^2 + (y - rhop .* sin(phip)).^2 + (z - zp).^2)).^(3/2));
        
        Bx_values(v, w) = integral3(Bx, 0, 1, 0, 2 * pi, -z0, z0);
        By_values(v, w) = integral3(By, 0.0001, 1, 0.0001, 2 * pi, -z0, z0);
        Bz_values(v, w) = integral3(Bz, 0.0001, 1, 0.0001, 2 * pi, -z0, z0);
        
        w = w + 1;
    end
    
    v = v + 1;
    w = 1;
end

%Representación del campo magnético en el plano x = 0
figure(1);
[y, z] = meshgrid(axis, axis);
quiver(y, z, By_values, Bz_values, 'LineWidth', 1);
title('Campo magnético en el plano x = 0');
xlabel('y'); %Revisar que estos label no estén cambiados
ylabel('z');

% Representación del campo magnético B, en el plano z = 0
figure(2);
[x, y] = meshgrid(axis, axis);
quiver(x, y, Bx_values, By_values, 'LineWidth', 1);
title('Campo magnético en el plano z = 0');
xlabel('x'); %Revisar que estos label no estén cambiados
ylabel('y');

% Representación 3D del campo magnético generado
figure(3);
quiver3(x, y, z, Bx_values, By_values, Bz_values, 'LineWidth', 1);


%Campo magnético en puntos lejanos

% Constantes
u = 4.*pi.*10.^(-7);
m0 = 1;

z = linspace(-10.*R, 10.*R, resolucion.^2);
Bz_axis_lejanos = -(u.*m0)./(2.*pi.*z.^3);
flat_Bz = reshape(Bz_values.', 1, []);

% Representación gráfica del campo en el eje z en ptos. lejanos
figure(4);
plot(z, Bz_axis_lejanos, z, flat_Bz);
title('Módulo del campo mgnético en el eje z');
legend('Momento magnético', 'Biot-Savart');

