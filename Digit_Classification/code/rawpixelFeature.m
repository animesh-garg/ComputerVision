function features = rawpixelFeature(digitsImage)
	features = double(reshape(digitsImage,[784 size(digitsImage,3)]));
end