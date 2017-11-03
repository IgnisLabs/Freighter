<?php

namespace IgnisLabs\Freighter;

use Illuminate\Support\ServiceProvider;

class FreighterServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $path = realpath(__DIR__.'/../');
        $this->publishes([
            $path.'/freighter' => base_path('freighter'),
        ]);
    }

    public function register() {}
}
