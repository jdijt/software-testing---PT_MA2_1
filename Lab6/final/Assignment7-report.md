# Report Assignment 7

## Source code
The source code for this assignment is located in the file [`Assignment7.hs`](Assignment7.hs).

## Generating large primes.
Several 1024 bit primes have been generated (`prime1`, `prime2`, `prime3` and `prime4` in the source file) using `getRandomPrime 1024`.

## Demonstrate RSA with primes:

The following code demonstrates creating a public / private keypair from prime1 and prime4.

It also demonstrates how a message encoded by the public key can be decoded using the private key and vice versa.

```
$ ghci Assignment7.hs
*Assignment7> let private_key = rsa_private prime1 prime4
*Assignment7> let public_key = rsa_public prime1 prime4
*Assignment7> let message = rsa_encode public_key 1337
*Assignment7> message
4272253717090457
*Assignment7> rsa_decode private_key  message
1337
*Assignment7> let message = rsa_encode private_key 1337
*Assignment7> message
13247703793371224018876122278078641679192246540609231886602600866682096397244273376131147590772208705680147679599959153907363846298079466118763285316493568170723071934615843458910924004351135733554905154024939281781629978380253558184531423773181391055072813030829197684445358575344392383306471588261689624784799077487671311755779722109075730360185511132135125446287447721301879075113303750198985780033196083044745190620676896123662631913858441674020629069498445023403275526681522048745850823835079769736918242048250620076857180452005501135893070180602628510670007481226659149939752551200853849058321753604766746460049
*Assignment7> rsa_decode public_key message
1337
*Assignment7>
```
