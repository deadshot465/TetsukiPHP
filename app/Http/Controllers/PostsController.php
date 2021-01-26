<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PostsController extends Controller
{
    private $posts = [
        1 => 'My first blog post!',
        2 => 'My second blog post!!'
    ];

    public function show_post($param) {
        if (!array_key_exists($param, $this->posts))
        {
            abort(404, 'Post not found.');
        }

        return view('test', [
            'param' => $this->posts[$param],
            'optional' => 'This is optional.'
        ]);
    }

    public function show_credits(int $index)
    {
        $content = DB::table('UserCredits')->get();
        dd($content[$index]);
    }
}
