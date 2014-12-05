clear
fileName = 'GA_LINEAR_001.mat'
load(fileName)
eval(['!mkdir ' fileName])

%%calculate only 2 waves from file : size(array,1)
numWavesFromFile = 10

calculatedWaves = CalculateCrossingWaves(s, t, numWavesFromFile)

%%render general graphic with ridges and througt (args:1 - calculatedListWaves, 2 - calculatedListsHeights)
%RenderGeneralGraphic2D(s, t, numWavesFromFile, calculatedWaves.calculatedListWaves)

HeightsDiagram(calculatedWaves.calculatedListWaves, calculatedWaves.calculatedListsHeights, numWavesFromFile)

RenderProbabilities(calculatedWaves.listProbabilitiesZDC, 'ZDC', numWavesFromFile)
RenderProbabilities(calculatedWaves.listProbabilitiesZUC, 'ZUC', numWavesFromFile)