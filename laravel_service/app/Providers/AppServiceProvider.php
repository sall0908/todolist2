<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Route;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        $this->routes();
    }

    /**
     * Define the routes for the application.
     */
    protected function routes(): void
    {
        // API Routes
        Route::prefix('api')
            ->middleware('api')
            ->group(base_path('routes/api.php'));

        // Web Routes
        Route::middleware('web')
            ->group(base_path('routes/web.php'));
    }
}
