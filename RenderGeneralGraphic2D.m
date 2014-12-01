function [] = RenderGeneralGraphic2D(array, t, numWavesFromFile, calculatedWaves)

h = figure()
grid on
for i = 1: numWavesFromFile
    
hold on
plot(t, array(i,:))

for indexWave = 1: size(calculatedWaves(1, i).calculatedWaves, 2)
    wave = calculatedWaves(1, i).calculatedWaves(indexWave)
    if strcmp(wave.type, 'ZDC')
        plot([wave.ridge, wave.ridge],[wave.amplMax, 0], '-')
        text(wave.ridge, wave.amplMax, num2str(wave.amplMax), 'VerticalAlignment','bottom','HorizontalAlignment','right', 'FontSize', 6)
    else
        plot([wave.trough, wave.trough],[wave.amplMin, 0],'-')
        text(wave.trough, wave.amplMin, num2str(wave.amplMin), 'VerticalAlignment','bottom','HorizontalAlignment','right', 'FontSize', 6)
    end
    
end

hold off

fileName = strcat('Wave ',num2str(i))

saveas(h,fileName,'fig')

clf(h)
end

end