// バリデーションに引っかかった際、リロードするとルーティングエラーになるのを防ぐため
history.replaceState('', '', 'users/sign_up')