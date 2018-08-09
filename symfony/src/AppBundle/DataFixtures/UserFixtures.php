<?php
namespace AppBundle\DataFixtures;

use AppBundle\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\Persistence\ObjectManager;

class UserFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        for ($i = 1; $i <= 3; ++$i) {
            $user = new User();
            $user->setEmail(sprintf('ahmedbhs12%s@gmail.com', $i));
            $user->setRoles(['ROLE_ADMIN']);
            $user->setPlainPassword('password');

            $manager->persist($user);
        }

        $manager->flush();
    }
}
