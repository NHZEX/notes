# 进程池通信示例
```php
<?php

use Swoole\Process;

$mapping = [
    0 => 3,
    1 => 2,
    2 => 1,
    3 => 0,
];

$pool = new Swoole\Process\Pool(4, SWOOLE_IPC_UNIXSOCK, 0, true);
$pool->on("WorkerStart", function (\Swoole\Process\Pool $pool, $workerId) use ($mapping) {
    /** @var Process $process */
    $process = $pool->getProcess();
    $process->name("worker #{$workerId}");

    $socket = $process->exportSocket();

    $targetId = $mapping[$workerId];

    $exitCount = 10;

    do {
        if (isset($recv)) {
            $exitCount--;
            echo "worker #{$workerId} recv: {$recv}\n";

            if (!$exitCount) {
                break;
            }
            \Co::sleep(1);
        }

        /** @var Process $targetProcess */
        $targetProcess = $pool->getProcess($targetId);
        $targetProcess->exportSocket()->send("worker #{$workerId} send({$exitCount}): " . date('Ymd His'));
    } while ($recv = $socket->recv());

    echo "worker #{$workerId}#{$process->pid} - exit \n";
    $process->exit();
});
$pool->on("WorkerStop", function (\Swoole\Process\Pool $pool, $workerId) {
    echo "Worker#{$workerId} is stopped\n";
});
$pool->start();
```