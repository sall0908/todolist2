<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('to_do_lists', function (Blueprint $table) {
            $table->bigIncrements('id_todo');
            $table->foreignId('id_users')->constrained('pengguna')->onDelete('cascade');
            $table->string('list');
            $table->date('tanggal');
            $table->text('deskripsi')->nullable();;
            $table->enum('status', ['low', 'medium', 'high'])->nullable();
            $table->boolean('selesai')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('to_do_lists');
    }
};
