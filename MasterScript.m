clear
fileName = 'GA_LINEAR_001.mat'
load(fileName)
eval(['!mkdir ' fileName])

%%calculate only 2 waves from file : size(array,1)
numWavesFromFile = 2

calculatedWaves = CalculateCrossingWaves(s, t, numWavesFromFile)

%%render general graphic with ridges and througt (args:1 - calculatedListWaves, 2 - calculatedListsHeights)
%RenderGeneralGraphic2D(s, t, numWavesFromFile, calculatedWaves.calculatedListWaves)

%HeightsDiagram(calculatedWaves.calculatedListWaves, numWavesFromFile)

RenderProbabilities(calculatedWaves.listProbabilitiesZDC, 'ZDC', calculatedWaves.calculatedListsHeights, numWavesFromFile)
%RenderProbabilities(calculatedWaves.listProbabilitiesZUC, 'ZUC', calculatedWaves.calculatedListsHeights, numWavesFromFile)