function [corrupted, filtered, den] = myPatchBasedFiltering(img,sigmaSpacial,sigmaIntensity)
    windowSize = 25;
    patchSize = 9;

    p = floor(patchSize/2);
    w = floor(windowSize/2);

    inRows = size(img,1);
    inCols = size(img,2);

    high = max(max(img));
    low = min(min(img));
    coeff = double((high - low)*0.05);
    corrupted = (double(img) + coeff*randn(size(img,1),size(img,2)));
    
    num = zeros(inRows,inCols);
    den = zeros(inRows,inCols);

    spacialDiff = zeros(windowSize, windowSize);
    intensityGaussian = zeros(windowSize, windowSize);

    window = zeros(windowSize, windowSize);

    for i = 1:inRows
        iWindowMin = max([1,i-w]);
        iWindowMax = min([inRows,i+w]);
        iPatchCenterMin = max([1,i-p]);
        iPatchCenterMax = min([inRows,i+p]);

        for j = 1:inCols 
            jWindowMin = max([1,j-w]);
            jWindowMax = min([inCols,j+w]);
            jPatchCenterMin = max([1,j-p]);
            jPatchCenterMax = min([inCols,j+p]);

            window =  corrupted(iWindowMin:iWindowMax,jWindowMin:jWindowMax);
            spacialDiff = log(exp(((iWindowMin:iWindowMax) - i).^2)' * exp(((jWindowMin:jWindowMax) - j).^2));
            intensityGaussian = zeros(iWindowMax-iWindowMin,jWindowMax-jWindowMin);

            for iWindow = iWindowMin:iWindowMax
                iPatchCompareMin = max([1,iWindow-p]);
                iPatchCompareMax = min([inRows,iWindow+p]);

                for jWindow = jWindowMin:jWindowMax
                    jPatchCompareMin = max([1,jWindow-p]);
                    jPatchCompareMax = min([inCols,jWindow+p]);

                    patchCenter = corrupted(iPatchCenterMin:iPatchCenterMax,jPatchCenterMin:jPatchCenterMax);
                    patchCompare = corrupted(iPatchCompareMin:iPatchCompareMax,jPatchCompareMin:jPatchCompareMax);
                    
                    if (iWindow - iPatchCompareMin < i - iPatchCenterMin)  
                        patchCenter = patchCenter(i-iPatchCenterMin-iWindow+iPatchCompareMin+1:end,:);
                    else
                        patchCompare = patchCompare(iWindow-iPatchCompareMin-i+iPatchCenterMin+1:end,:); 
                    end
                    if (jWindow - jPatchCompareMin < j - jPatchCenterMin)  
                        patchCenter = patchCenter(:,j-jPatchCenterMin-jWindow+jPatchCompareMin+1:end);
                    else
                        patchCompare = patchCompare(:,jWindow-jPatchCompareMin-j+jPatchCenterMin+1:end); 
                    end
                    if (iPatchCompareMax - iWindow < iPatchCenterMax - i)  
                        patchCenter = patchCenter(1:end+(iPatchCompareMax-iWindow)-(iPatchCenterMax-i),:);
                    else
                        patchCompare = patchCompare(1:end-(iPatchCompareMax-iWindow)+(iPatchCenterMax-i),:); 
                    end
                    if (jPatchCompareMax - jWindow < jPatchCenterMax - j)  
                        patchCenter = patchCenter(:,1:end+(jPatchCompareMax-jWindow)-(jPatchCenterMax-j));
                    else
                        patchCompare = patchCompare(:,1:end-(jPatchCompareMax-jWindow)+(jPatchCenterMax-j)); 
                    end

                    patchDiff = sum(sum((patchCompare-patchCenter).^2));
                    intensityGaussian((iWindow - iWindowMin + 1),(jWindow - jWindowMin + 1)) = exp(-patchDiff/(sigmaIntensity)^2);
                end
            end
            spacialGaussian = exp((spacialDiff*(-0.5))/(sigmaSpacial*sigmaSpacial));
            t = spacialGaussian.*intensityGaussian;
            num(i,j) = sum(sum(window.*t));
            den(i,j) = sum(sum(t));
        end
    end
    filtered = uint8(num./den);
    
end