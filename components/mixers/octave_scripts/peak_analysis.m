
function [pr, pc] = peak_analysis (sweep, rax, cax, baseLine)
	pr=[];
	pc=[];
	for r = 1:length(rax)
		row=sweep(r,:);
		zadj=row-baseLine;
		[pk, idx] = findpeaks(zadj, "MinPeakHeight",5);
		for i=1:length(idx)
			pc=[pc idx(i)];
			pr=[pr r];

		end
		%plot(cax, row);
	end
	%hold on
	%plot(cax(idx), row(idx), 'x')
	%plot(cax, baseLine);
endfunction
