function mask = myForegroundMask(img)
    mask = uint8(img>15);    
end