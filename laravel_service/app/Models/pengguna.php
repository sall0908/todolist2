<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\to_list;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Pengguna extends Authenticatable
{
    use HasFactory;
    use HasApiTokens, Notifiable;

    protected $table = 'pengguna';

    protected $fillable = ['username', 'email', 'password', 'pp'];

    public function todolist()
    {
        return $this->hasMany(to_list::class, 'id_users', 'id');
    }

}
