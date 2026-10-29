

%% G = 1/((s+1)(0.5s+1))

G = tf(1, [1 1]) * tf(1, [0.5 1]);
info = stepinfo(G);

figure

step(G);
xlim([0 6])
grid on
title('Step response G(s)')

theme(gcf, 'light'); 
exportgraphics(gcf, 'report/figures/3_1/g-step.png');

results = struct2table(info(:));
results = results(:, {'Overshoot', 'Undershoot'});

writetable(results, 'report/tables/3_1/g-step-overshoot.csv');

%% G_c = (-s + c)/(c(s+1)(0.5s+1))

Gc = @(c) tf([-1 c], c) * tf(1, [1 1]) * tf(1, [0.5 1]);
c = {-10 -0.25 -0.1 0.1 0.25 10};

Gc = cellfun(Gc, c, 'UniformOutput', false);
info = cellfun(@stepinfo, Gc);
label = @(c) sprintf('c = %g', c);
labels = cellfun(label, c, 'UniformOutput', false);

figure

step(Gc{:})
xlim([0 6])
grid on
title('Step response G_c(s)')
legend(labels)

theme(gcf, 'light'); 
exportgraphics(gcf, 'report/figures/3_1/g_c-step.png');

results = struct2table(info(:), "RowNames", string(cell2mat(c)));
results = results(:, {'Overshoot', 'Undershoot'});
results.Properties.DimensionNames{1} = 'c';

writetable(results, 'report/tables/3_1/g_c-step-overshoot.csv', "WriteRowNames", true);
