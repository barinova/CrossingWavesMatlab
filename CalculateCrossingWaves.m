function [returnDate] = CalculateCrossingWaves(array, t, numWavesFromFile)

for i = 1:1:numWavesFromFile%%size(array,2)
    clear global listHeihtsZDC listThroughAZDC listCrestAZDC listHeihtsZUC listCrestAZUC listThroughAZUC h
    listHeihtsZDC = 0
    listThroughAZDC = 0
    listHeihtsZUC = 0
    listCrestAZUC = 0
    listThroughAZUC = 0
    numWave = 1
    for j = 1:1:size(array,2)-1
        if (array(i, j)*array(i, j+1))<0
            %%
            if array(i, j) > 0
                type = 'ZDC'
            else
                type = 'ZUC'
            end
            %%
            newWave = GetSingleWave(type , array, t, i, j); 

            if	newWave.totalHeight == 0
                global listHeihtsZDC listThroughAZDC listCrestAZDC listHeihtsZUC listCrestAZUC listThroughAZUC h
                
                %%delete 1st element==0 because initalization oh matlab..
                listHeihtsZDC(1) = []
                listThroughAZDC(1) = []
                listCrestAZDC(1) = []
                listHeihtsZUC(1) = []
                listCrestAZUC(1) = []
                listThroughAZUC(1) = []
                
                %%copy because 2 dimentional matrix - matlab =(
                listHeihtsZDC = [listHeihtsZDC, 0]
                listCrestAZDC = [listCrestAZDC, 0]
                listThroughAZDC = [listThroughAZDC, 0]
                listHeihtsZUC = [listHeihtsZUC, 0]
                listCrestAZUC = [listCrestAZUC, 0]
                listThroughAZUC = [listThroughAZUC, 0]
                
                %%setHeights 1/3 and significiant             
                %zdc.type = 'ZDC';
                significantHeightZDC = significantHeights(listHeihtsZDC)
                heightOneThirdZDC = heightOneThird(listHeihtsZDC)
                sigmaZDC = setSigma(listHeihtsZDC, heightOneThirdZDC)

                if i == 1
                    h(1).type = 'ZDC'
                    h(1).significantHeight = significantHeightZDC
                    h(1).heightOneThird = heightOneThirdZDC
                    h(1).sigma = sigmaZDC
                else
                    sizeH = size(h, 1)
                    h(sizeH + 1).type = 'ZDC'
                    h(sizeH + 1).significantHeight = significantHeightZDC
                    h(sizeH + 1).heightOneThird = heightOneThirdZDC
                    h(sizeH + 1).sigma = sigmaZDC
                end
                clear significantHeight heightOneThird sigma
                
                %zuc.type = 'ZUC';
                significantHeightZUC = significantHeights(listHeihtsZUC)
                heightOneThirdZUC = heightOneThird(listHeihtsZUC)
                sigmaZUC = setSigma(listHeihtsZUC, heightOneThirdZUC)
                sizeH = size(h, 1)
                h(sizeH+1).type = 'ZDC'
                h(sizeH+1).significantHeight = significantHeightZUC
                h(sizeH+1).heightOneThird = heightOneThirdZUC
                h(sizeH+1).sigma = sigmaZUC
                clear significantHeight heightOneThird  sigma  
                
                break
                %%
            end
            %%'sec', newWave.sec
            calculatedWaves(numWave) = struct('type', newWave.type, 'amplMax', newWave.amplMax, 'amplMin', newWave.amplMin, 'totalHeight', newWave.totalHeight, 'verticalAsummetry', newWave.verticalAsummetry, 'horizontalAsymmetry', newWave.horizontalAsymmetry, 'nullPoint', newWave.nullPoint, 'trough', newWave.trough, 'ridge', newWave.ridge)
            numWave = numWave + 1
        end
    end
        listProbabilitiesZDC(i) = struct('listProbabilitiesZDC', setListProbabilities(listHeihtsZDC, listCrestAZDC, listThroughAZDC, 'ZDC', h))
        listProbabilitiesZUC(i) = struct( 'listProbabilitiesZUC', setListProbabilities(listHeihtsZUC, listCrestAZUC, listThroughAZUC, 'ZUC', h))
        calculatedListWaves(i) = struct('calculatedWaves', calculatedWaves)
        calculatedListsHeights(i) = struct('listHeihtsZDC', listHeihtsZDC, 'listThroughAZDC', listThroughAZDC, 'listCrestAZDC', listCrestAZDC, 'listHeihtsZUC', listHeihtsZUC, 'listCrestAZUC', listCrestAZUC, 'listThroughAZUC', listThroughAZUC, 'h', h)
end
    returnDate = struct('calculatedListWaves', calculatedListWaves, 'calculatedListsHeights', calculatedListsHeights, 'listProbabilitiesZDC', listProbabilitiesZDC, 'listProbabilitiesZUC', listProbabilitiesZUC)
end


 function [waveEntity] = GetSingleWave(type, array, t, i, j)
    global listHeihtsZDC listThroughAZDC listCrestAZDC listHeihtsZUC listCrestAZUC listThroughAZUC
     k = 1
     waveEntity.type = type
     waveEntity.nullPoint(k) = (t(i+1) * array(i, j) - t(i) * array(i,j+1))/(array(i, j) - array(i, j+1))
     waveEntity.amplMax = 0
     waveEntity.amplMin = 0
     currentPoint.sec = waveEntity.nullPoint(k)
     currentPoint.shift = 0

     waveEntity.totalHeight = 0
     k=k+1
     
     while k<4
	%%
         retPoint = amplMax(currentPoint, waveEntity.amplMax)
         
         if retPoint.shift ~= 0
             waveEntity.ridge = retPoint.sec
             waveEntity.amplMax = retPoint.shift
         end
         
         retPoint = amplMin(currentPoint, waveEntity.amplMin)
         
         if retPoint.shift ~= 0
             waveEntity.trough = retPoint.sec
             waveEntity.amplMin = retPoint.shift
         end
         
         if  j < size(array, 2) - 1
             if (currentPoint.shift * array(i,j+1) < 0)
                 waveEntity.nullPoint(k) = (t(i+1) * array(i, j) - t(i) * array(i,j+1))/(array(i, j) - array(i, j+1))
                 k=k+1
             end
         end
         
         j=j+1
         
         if j > size(array, 2)
            return
         end
            currentPoint.shift = array(i, j)
            currentPoint.sec = t(j)
     end
     waveEntity.verticalAsummetry = abs(waveEntity.amplMax / waveEntity.amplMin)
     waveEntity.horizontalAsymmetry = (waveEntity.nullPoint(2) - waveEntity.nullPoint(1))/ (waveEntity.nullPoint(3) - waveEntity.nullPoint(2))
     waveEntity.totalHeight = abs(waveEntity.amplMax) + abs(waveEntity.amplMin)
     
     if strcmp(waveEntity.type,'ZDC')
         listHeihtsZDC = [listHeihtsZDC, waveEntity.totalHeight]
         listCrestAZDC = [listCrestAZDC, waveEntity.amplMax]
         listThroughAZDC = [listThroughAZDC, - waveEntity.amplMin]
     else
         listHeihtsZUC = [listHeihtsZUC, waveEntity.totalHeight]
         listCrestAZUC = [listCrestAZUC, waveEntity.amplMax]
         listThroughAZUC = [listThroughAZUC, - waveEntity.amplMin]
     end

 end

function [ret] = amplMax(point, amplMax)
    if point.shift > amplMax
        ret.shift = point.shift
        ret.sec = point.sec
    else
        ret.shift = 0
    end
end

function [ret] = amplMin(point, amplMin)
    if point.shift < amplMin
        ret.shift = point.shift
        ret.sec = point.sec
    else
        ret.shift = 0
    end
end

function [ret] = significantHeights(listHeights)
    sizeH = size(listHeights, 2)
	tmpHeight = 0
	heightSignificant = 0
    for i = 1:1:sizeH
        tmpHeight = listHeights(i)
        heightSignificant = heightSignificant + tmpHeight
    end
    
    tmp = heightSignificant/sizeH
    ret = sqrt(4.04*heightSignificant/sizeH)
end

function [ret] = heightOneThird(listHeights)
    sizeTmp = 0
    sizeH = size(listHeights, 2)
    heightSignificant = 0
    sizeTmp = round(2 * (sizeH/3))
    tmp = sizeH - sizeTmp
    listHeights = sort(listHeights)
    
    for i = sizeTmp:1:sizeH
        heightSignificant =  heightSignificant + listHeights(i)
    end
        ret = heightSignificant/(sizeH - sizeTmp)
end

function [ret] = setSigma(listHeights, sighificiantHeight)
    sigma = 0
    sizeH = size(listHeights, 2)
    %if sign heights != 0
    for i = 1:1:sizeH
        sigma = sigma + sqrt((listHeights(i) - sighificiantHeight)*(listHeights(i) - sighificiantHeight))
    end
    ret = sigma/sizeH
end

function [ret] = setListProbabilities(listHeights, listCrestA, listThroughA, typeWave, h)
    N = size(listHeights)
    listHeights = sort(listHeights)
    listCrestA = sort(listCrestA)
    listThroughA = sort(listThroughA)
    numProbabilitiesZUC = 1
    numProbabilitiesZDC = 1
    %%Pteor exp(-H^2/(8*Hsign^2))\n"
    for i = 1 : size(listHeights, 2)
        %% h : 1 - ZDC, 2 - ZUC
        if strcmp(typeWave,'ZDC')
            type = 1
        else
            type = 2
        end
        
        signH = h(type).significantHeight*h(type).significantHeight
        waveFrequency = (N-i)/N
        obj.H = listHeights(i)
        obj.experP = waveFrequency
        obj.teorP = exp(-obj.H * obj.H/(8*h(type).sigma * h(type).sigma))
        obj.crestP = exp(- 2 * (2 * listCrestA(i)/h(type).significantHeight * 2 * listCrestA(i)/h(type).significantHeight))
        obj.troughP = exp(- 2 * (2 * listThroughA(i)/h(type).significantHeight * 2 * listThroughA(i)/h(type).significantHeight))
        obj.teorP = exp(-obj.H * obj.H/(2*h(type).sigma * h(type).sigma))
        if type == 2
            listProbabilitiesZUC(numProbabilitiesZUC) = obj
            numProbabilitiesZUC = numProbabilitiesZUC + 1
        else
            listProbabilitiesZDC(numProbabilitiesZDC) = obj
            numProbabilitiesZDC = numProbabilitiesZDC + 1
        end
    end
    
    if type == 1
        ret = listProbabilitiesZDC
    else
        ret = listProbabilitiesZUC
    end
    
end