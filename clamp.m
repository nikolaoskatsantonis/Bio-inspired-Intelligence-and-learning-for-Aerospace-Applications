function value = clamp(value,minvalue,maxvalue)
value = max(min(value,maxvalue),minvalue);
end