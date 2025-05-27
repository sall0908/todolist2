<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\Pengguna;
class to_list extends Model
{
    use HasFactory;

    protected $table= 'to_do_lists';

    protected $primaryKey = 'id_todo';
    protected $fillable = [
        'id_users',
        'list',
        'tanggal',
        'deskripsi',
        'status',
        'selesai',
        ];
    public function pengguna()
    {
        return $this->belongsTo(Pengguna::class, 'id_users', 'id');
    }
}
