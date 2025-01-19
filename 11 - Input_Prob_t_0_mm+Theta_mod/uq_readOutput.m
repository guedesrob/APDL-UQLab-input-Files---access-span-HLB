function Y = uq_readOutput(outputfile)
format long;
% Read the s i n g l e l i n e of the f i l e , which co r r e s pon d s to the
% sought midspan beam d e f l e c t i o n
Y = dlmread(outputfile) ;
end