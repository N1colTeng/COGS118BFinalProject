% viewcolumn(columnvector);
%
% VIEWCOLUMN Displays a 60 x 60 grayscale image stored in a column vector.
%
% Tim Marks 2002

function  h = viewcolumn(columnvector);

height = 15; 
width = 16;

colormap(gray(256));
img = reshape(columnvector,height,width);
hh = imagesc(img);
axis image;

if nargout > 0
    h = hh;
end

