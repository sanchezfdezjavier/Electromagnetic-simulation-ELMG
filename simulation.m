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
x_plot = linspace(-8.*R, 8.*R, resolucion);

%Variables de iteración
v = 1;
w = 1;

%Almacén de valores
Bx_values = zeros(10);
By_values = Bx_values;
Bz_values = Bx_values;


%Cálculo de todas las componentes de campo magnético B: Bx, By y Bz.
for z = x_plot
  
    for y = x_plot
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
[y, z] = meshgrid(x_plot, x_plot);
quiver(y, z, By_values, Bz_values, 'LineWidth', 1);
title('Campo magnético en el plano x = 0');
xlabel('y'); %Revisar que estos label no estén cambiados
ylabel('z');

% Representación del campo magnético B, en el plano z = 0
figure(2);
[x, y] = meshgrid(x_plot, x_plot);
quiver(x, y, Bx_values, By_values, 'LineWidth', 1);
title('Campo magnético en el plano z = 0');
xlabel('x'); %Revisar que estos label no estén cambiados
ylabel('y');

% Representación 3D del campo magnético generado
figure(3);
quiver3(x, y, z, Bx_values, By_values, Bz_values, 'LineWidth', 1);


% Aproximación de campo lejano por momento magnético frente al calculo
% real por Biot-Savart

% Constantes
u = 4.*pi.*10.^(-7); % permeabilidad magnética del vacío
m0 = 1;              

z = linspace(0, 5.*R, 50);
Bz_axis_lejanos = (u.*m0)./(2.*pi.*z.^3);

% Representación gráfica del campo en el eje z en ptos. lejanos
figure(4);
plot(z, Bz_axis_lejanos,'-o', z, modulo(51:100, 50),'-o', 'LineWidth', 2);
title('Módulo del campo magnético en el eje z');
legend('Momento magnético', 'Biot-Savart');
axis([0 10 0 10]);

% Solo aproximación de puntos lejanos, pero en cercanos
plot(z, Bz_axis_lejanos,'-o', 'LineWidth', 2);
%hold on
%plot(z, modulo(51:100, 50), '-o', 'LineWidth', 2);


% Surf Bz
figure(5);
surf(x,y, Bz_values);

% Contour(Valor absoluto del campo z)
figure(6);
contour(x,y, Bz_values, 'LineWidth', 1.5);

% Surf By
figure(7);
surf(x,y, By_values);

% Contour
figure(8);
contour(x, y, By_values, 'LineWidth', 1.5);

% Módulo del campo magnético
figure(9);
modulo = sqrt(Bx_values.^2 + By_values.^2 + Bz_values.^2);
plot(-49:50, modulo,'LineWidth', 2);
figure(10);
surf(x,y, modulo);


% Pruebas
plot(z, Bz_axis_lejanos, z, modulo(51:100, 50), 'LineWidth', 1.5);



