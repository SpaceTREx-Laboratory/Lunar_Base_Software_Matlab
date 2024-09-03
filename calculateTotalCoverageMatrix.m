function covered_area = calculateTotalCoverageMatrix(sensorPositions, binaryImage, sensorRadius)
    [x, y] = meshgrid(1:size(binaryImage, 2), 1:size(binaryImage, 1));
    coverageMatrix = false(size(binaryImage));
    
    for i = 1:size(sensorPositions, 1)
        distanceSquared = (x - sensorPositions(i, 1)).^2 + (y - sensorPositions(i, 2)).^2;
        coverageMatrix = coverageMatrix | (distanceSquared <= sensorRadius^2);
    end
    covered_area = coverageMatrix > 0 & binaryImage == 1;
end