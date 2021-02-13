<?php

namespace App\Http\Controllers;

use App\Models\Player;
use Illuminate\Http\Request;

class PlayersController extends Controller
{
    public function get_all_players()
    {
        $content = Player::all();
        dd($content);
    }
}
