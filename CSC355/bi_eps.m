left = -64;
right = 64;

while right > left
    mid = round((left + right) / 2);
    if 2^(mid) > eps
        right = mid;
    else
        left = mid+1;
    end
end

right+1