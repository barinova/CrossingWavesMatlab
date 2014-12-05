function [  ] = RenderProbabilities(listProbabilities, typeWave, numWavesFromFile)
 for i = 1 : numWavesFromFile
     
f = figure()
    grid on
    hold on
fLog = figure()
    grid on
    hold on
    if strcmp(typeWave, 'ZDC')
        type = 1
        sizeP = size(listProbabilities(1,i).listProbabilitiesZDC, 2)
    else
        type = 2
        sizeP = size(listProbabilities(1,i).listProbabilitiesZUC, 2)
    end
        
     for j = 2: sizeP
        if type == 1
            probability = listProbabilities(1,i).listProbabilitiesZDC(j)
            prev = listProbabilities(1,i).listProbabilitiesZDC(j - 1)
        else
            probability = listProbabilities(1,i).listProbabilitiesZUC(j)
            prev = listProbabilities(1,i).listProbabilitiesZUC(j - 1)
        end

        set(0, 'CurrentFigure', f)
        plot([prev.H, probability.H],[prev.teorP, probability.teorP], 'LineWidth', 2)
        plot([prev.H, probability.H],[prev.experP, probability.experP], 'Color', 'r', 'LineWidth', 2)
        plot([prev.H, probability.H],[prev.crestP, probability.crestP],'Color', 'm', 'LineWidth', 2)
        plot([prev.H, probability.H],[prev.troughP, probability.troughP], 'Color', 'g', 'LineWidth', 2)
        plot([prev.H, probability.H],[prev.teorP, probability.teorP], 'k.')
        plot([prev.H, probability.H],[prev.experP, probability.experP], 'k.')
        plot([prev.H, probability.H],[prev.crestP, probability.crestP], 'k.')
        plot([prev.H, probability.H],[prev.troughP, probability.troughP], 'k.')
        

        set(0, 'CurrentFigure', fLog)
        plot([log10(prev.H), log10(probability.H)],[prev.teorP, probability.teorP], 'LineWidth', 2)
        plot([log10(prev.H), log10(probability.H)],[prev.experP, probability.experP],'Color', 'r', 'LineWidth', 2)
        plot([log10(prev.H), log10(probability.H)],[prev.crestP, probability.crestP], 'Color', 'm', 'LineWidth', 2)
        plot([log10(prev.H), log10(probability.H)],[prev.troughP, probability.troughP], 'Color', 'g', 'LineWidth', 2)
        plot([log10(prev.H), log10(probability.H)],[prev.teorP, probability.teorP], 'k.')
        plot([log10(prev.H), log10(probability.H)],[prev.experP, probability.experP], 'k.')
        plot([log10(prev.H), log10(probability.H)],[prev.crestP, probability.crestP], 'k.')
        plot([log10(prev.H), log10(probability.H)],[prev.troughP, probability.troughP], 'k.')
     end
     
    set(0, 'CurrentFigure', f)
    legend('teorelical probability','experimental probability','crests probability ','trough probability')
    set(0, 'CurrentFigure', fLog)
    legend('teorelical probability','experimental probability','crests probability ','trough probability')
        
    hold off
    if type == 1
        fileName = strcat('Probabilities zero down crossing wave ', num2str(i))
        saveas(f, fileName,'fig')
        fileName = strcat('Probabilities(Log) zero down crossing wave ', num2str(i))
        saveas(fLog, fileName,'fig')
    else
        fileName = strcat('Probabilities zero up crossing wave ', num2str(i))
        saveas(f, fileName,'fig')
        fileName = strcat('Probabilities(Log) up down crossing wave ', num2str(i))
        saveas(fLog,fileName ,'fig')
    end
    
    close(f)
    close(fLog)
 end
end

