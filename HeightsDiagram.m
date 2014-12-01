function [] = HeightsDiagram(calculatedWaves, numWavesFromFile )

for i = 1: numWavesFromFile
    fZDC = figure() 
    grid on
    hold on
    fZUC = figure()
    grid on
    hold on
    
    for indexWave = 1: size(calculatedWaves(1, i).calculatedWaves, 2)
        wave = calculatedWaves(1, i).calculatedWaves(indexWave)
        if strcmp(wave.type, 'ZDC')
            set(0, 'CurrentFigure', fZDC)
        else
            set(0, 'CurrentFigure', fZUC)
        end
        plot([indexWave, indexWave],[0, wave.totalHeight], 'Color', 'r', 'LineWidth', 2)
        text(indexWave, wave.totalHeight, num2str(wave.totalHeight), 'VerticalAlignment','bottom','HorizontalAlignment','right', 'FontSize', 6)
    end
    hold off
    
    fileName = strcat('Diagram heights zero down crossing wave ',num2str(i))
    saveas(fZDC,fileName,'fig')
    fileName = strcat('Diagram heights zero up crossing wave ',num2str(i))
    saveas(fZUC,fileName,'fig')
    
    clf(fZDC)
    clf(fZUC)
end
close(fZDC)
close(fZUC)
end

