function saveImg(h,name)
saveas(h,['../report/images/' name '.jpg'],'jpg');
saveas(h,['../report/images/' name '.eps'],'epsc');
saveas(h,['../report/images/' name '.fig'],'fig');
end
