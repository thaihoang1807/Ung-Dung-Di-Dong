import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { CloudSun, MapPin, Thermometer } from 'lucide-react';

type WeatherProps = {
  temperature: number;
  weather: string;
  location: string;
};

export const Weather = ({ temperature, weather, location }: WeatherProps) => {
  return (
    <Card className="w-full max-w-md">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <CloudSun className="h-5 w-5 text-blue-500" />
          Weather Information
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-3">
        <div className="flex items-center gap-2">
          <MapPin className="h-4 w-4 text-gray-500" />
          <span className="font-semibold">{location}</span>
        </div>
        <div className="flex items-center gap-2">
          <Badge variant="secondary" className="text-sm">
            {weather}
          </Badge>
        </div>
        <div className="flex items-center gap-2">
          <Thermometer className="h-4 w-4 text-red-500" />
          <span className="text-2xl font-bold">{temperature}°F</span>
        </div>
      </CardContent>
    </Card>
  );
};

