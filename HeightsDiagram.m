function [] = HeightsDiagram(calculatedWaves, calculatedListsHeights, numWavesFromFile )

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
    
    set(0, 'CurrentFigure', fZDC)
    text(0, 0, 'zero-down-crossing', 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    text(0, -0.2, strcat('Height 1/3 : ', num2str(calculatedListsHeights(i).h(1).heightOneThird)), 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    text(0, -0.4, strcat('Significiant height : ', num2str(calculatedListsHeights(i).h(1).significantHeight)), 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    
    set(0, 'CurrentFigure', fZUC)
    text(0, 0, 'zero-up-crossing', 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    text(0, -0.2, strcat('Height 1/3 :', num2str(calculatedListsHeights(i).h(2).heightOneThird)), 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    text(0, -0.4, strcat('Significiant height :', num2str(calculatedListsHeights(i).h(2).significantHeight)), 'VerticalAlignment','top','HorizontalAlignment','left', 'FontSize', 6)
    
    

    hold off
    
    fileName = strcat('Diagram heights zero down crossing wave ', num2str(i))
    saveas(fZDC,fileName,'fig')
    fileName = strcat('Diagram heights zero up crossing wave ', num2str(i))
    saveas(fZUC,fileName,'fig')   
    close(fZDC)
    close(fZUC)
end
end

