<?php

namespace IgnisLabs\Freighter;

use Illuminate\Support\ServiceProvider;

class FreighterServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $path = realpath(__DIR__.'/../');
        $this->publishes([
            $path.'/docker' => base_path('docker'),
            $path.'/freighter.d' => base_path('freighter.d'),
            $path.'/freighter' => base_path('freighter'),
        ]);
    }

    public function register() {}
}
