<?php
    // Update the path below to your autoload.php,
    // see https://getcomposer.org/doc/01-basic-usage.md
    require_once '/path/to/vendor/autoload.php';
    use Twilio\Rest\Client;

    $sid    = "ACba4f5d095117f8ba685f9ec3b5ee1c97";
    $token  = "8b9c9bd1231c8ac032a1570929c84df8";
    $twilio = new Client($sid, $token);

    $message = $twilio->messages
      ->create("+351962601852", // to
        array(
          "from" => "+12184838824",
          "body" => Tens de Pagar a conta da Agua do Mês de Janeiro, valor 26,90€
        )
      );

print($message->sid);