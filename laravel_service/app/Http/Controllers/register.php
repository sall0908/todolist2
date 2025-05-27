<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengguna;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class register extends Controller
{
    //register pengguna
    public function signup(Request $request)
    {
        $fields = $request->validate([
            'username' => 'required|string|unique:pengguna,username',
            'email' => 'required|string|email|unique:pengguna,email',
            'password' => 'required|string',
        ]);

        $pengguna = Pengguna::create([
            'username' => $fields['username'],
            'email' => $fields['email'],
            'password' => bcrypt($fields['password']),
        ]);


        return response()->json([
            'user' => $pengguna,

        ], 201);
    }

    //login pengguna
    public function signin(Request $request)
    {
        $fields = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $pengguna = Pengguna::where('email', $fields['email'])->first();

        if (!$pengguna || !Hash::check($fields['password'], $pengguna->password)) {
            throw ValidationException::withMessages([
                'email' => ['Email atau password salah.'],
            ]);
        }
        $token = $pengguna->createToken('token-auth')->plainTextToken;

            return response()->json([
                'user' => $pengguna,
                'token' => $token,
            ], 200);
    }

    //logout pengguna
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out',
        ]);
    }
}
