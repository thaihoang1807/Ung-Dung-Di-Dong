import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { TrendingUp, DollarSign } from 'lucide-react';

type StockProps = {
  price: number;
  symbol: string;
};

export const Stock = ({ price, symbol }: StockProps) => {
  return (
    <Card className="w-full max-w-md">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <TrendingUp className="h-5 w-5 text-green-500" />
          Stock Information
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-3">
        <div className="flex items-center justify-between">
          <Badge variant="outline" className="text-lg font-semibold">
            {symbol}
          </Badge>
          <div className="flex items-center gap-1">
            <DollarSign className="h-5 w-5 text-green-600" />
            <span className="text-3xl font-bold text-green-600">{price}</span>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

