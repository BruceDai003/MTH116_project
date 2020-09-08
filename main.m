A = csvread('AAPL.csv', 1, 1);
% Plot the curves for the prices
figure;
colors = {'r', 'b', 'g', 'y'};
for i = 1:4
    plot(A(:, i), colors{i});
    hold on
end
legend({'Open', 'High', 'Low', 'Close'});
xlabel('time');
ylabel('price');
title('AAPL price');

% Find the mean and std
mean_price = sum(A(:, 4)) / numel(A(:, 4));
std_price = std(A(:, 4));
mean_price
std_price

% How many days above the mean of close price
n_days = sum(A(:, 4) > mean_price);
n_days

% Trade strategy analysis
total_days = numel(A(:, 1));
init_shares = 1000;
buy_price_line = 200;
sell_price_line = 290;
buy_prices = [];
sell_prices = [];
current_shares = init_shares;
for i = 1:total_days
    % First, check if we can sell
    if current_shares >= 100 && A(i, 1) > sell_price_line
        sell_prices(end+1) = A(i, 1);
        current_shares = current_shares - 100;
    elseif A(i, 1) < buy_price_line
        buy_prices(end+1) = A(i, 1);
        current_shares = current_shares + 100;
    end
end

% Number of shares owned
n_shares_owned = current_shares;

% Now calcuate the cash flow first
cash_in_flow = 100*(sum(sell_prices) - sum(buy_prices));
cash_in_flow
% Then calculate the net increase in our portfolio( including stocks and
% cash)
net_increase = n_shares_owned * A(end, 4) - init_shares * A(1, 1) + cash_in_flow;
net_increase


