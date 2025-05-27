<?php
use App\Http\Controllers\register;
use App\Http\Controllers\listcont;
use Illuminate\Support\Facades\Route;

Route::post('/signup', [register::class, 'signup']);
Route::post('/signin', [register::class, 'signin']);


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/todos', [listcont::class, 'index']);
    Route::post('/todos', [listcont::class, 'store']);
    Route::put('/edit/{id}', [listcont::class, 'update']);
    Route::delete('/todos/{id}', [listcont::class, 'destroy']);
    Route::post('/logout', [register::class, 'logout']);
});
