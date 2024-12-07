Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042528FC
	for <netfs@lists.linux.dev>; Sat,  7 Dec 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548860; cv=none; b=WR/D+BTlHOxmow20zmBR9duY98MzeAXYM0CnzxvTk4t7r/b3FK42N8eu8eBZYvaqD5I6Mz1APJrKQteD4Rn7/n9BtNVkrGTebpSdbLqOh6nePXzzLUgzgdGtvql2ROxQGQHTbtyOAxDmgruMcneHinqtTkTMCMkk/vt18Y8wLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548860; c=relaxed/simple;
	bh=UmRWd+KnaOk8lwGdV90X50BQsmkbfC+/nmOzsHXJwnc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EigJSuVw7KOFH74cDG/sSYRsREzFCS8cgTUGWZ1xS1RH744wxD719KDRrSe7+LNBLuYwl5JrelLKIPMHmSyhUhLtePG6S55YMNWGLa2/3grCbf5uQ/W/lLQMypb2pXCrETXTVKpREEgt/lBTFEZBfqNwdd7Tma2Qrcv/9HEUSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPeMMAx0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPeMMAx0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so2011690a91.0
        for <netfs@lists.linux.dev>; Fri, 06 Dec 2024 21:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733548858; x=1734153658; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBXfTQztGpMrB5MxGg0g8xradodaYggvMylTYoes3J4=;
        b=lPeMMAx0Tin4WcrgjWOrZN4I2nPe1NaHeNMJ8zCFnRsSAXmQlNr16fzDYn4SW1R2cU
         RlFmocP/98egeW2Su0hOA0Ht7xBypb/JRAkyZ6Vk2l8tnRt3K6Dv7z6qQoLJa5+ezn/Z
         MVaCNIW4gmWFHTGG1A0G/eIO2ZF4jE84I1shyTSkeq7eg2A8/ELtfJBf8N6vSCKoGaWJ
         ryUZ/a5dm5ClLjmAFjsgNnUtWdZ5KUsw7vRfdVneB4d3jM75+0TgWf0CvqpHrvLSWwE2
         8Q/KwlSZc59tPsDVydetyengO/W5IvFUHk1qzo6jpQDTvrK5iYeQBar9ZTZKPamVYpzU
         cMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733548858; x=1734153658;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBXfTQztGpMrB5MxGg0g8xradodaYggvMylTYoes3J4=;
        b=MVetuS3jEWhh3TdnMZF3tiydHP9xMBf/oHmJ9eIrv194HULuqN97yc65JO2G10vLeu
         mO8LbH06yA8MB4usGu6WqD2UZhFxU/qVYX6LnzTpyLe2ch3zzw8s422QtURXL5WWqJE6
         92BtkY32Iqp5dzcPZ2qRcPilEZMILNtYdwFkc2r+oPuWFtDbeK/UeMqjgW901QbhkESJ
         2fCqnVF9DddvRQWVUA6BLatUZs2t+kiIquYWG8ESpEHh4BcnrY6vMqGhWPdmTg3Dg5uu
         IllPrDZLeQqTKj+RCBO4o5xkr3ZbxEk9Qi4Tw341kjsw2qSAkpl1KnJRAuCqko16rh9n
         fjbg==
X-Forwarded-Encrypted: i=1; AJvYcCX1uodKkcGZ4XCdUKiS2i8UlC4PRtzFFhiNXXQMh5PPU5WioEs6B67AHFeB1sZGH4C1jIM/rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxipKF8zrwcEepfe7bS43th7KRXnaCd3wB2Ltj8a3Efw5LQasXu
	T9a12ns2PA6hpgfgKSh3jLTZl6Cxh1BK0EnSrSVo217kvjZw10rD
X-Gm-Gg: ASbGncvBJMNRfoNtKUQjtG8vPKQ3K2nrbsrFr6Dedre69FF7tKD48dukU/lfET/9CpZ
	9rvRMoAdYccBPZZG0XrdYo/kxGvFzl7dVFjYmA5smPQEWbTGGLLN6BPCDddFHirrs3m8zgFq8ip
	IpTmiZ3j3foUV6lpCHfNGdwCuSSji3bs9Jgaf4YVcHzH2X/Z38tPHS9so3i/nEhUDUifPBRKFX/
	+bHqt0BO9DsxXEmUz4d+vyfBYO5hs+PnfrRsHJyL1wdRLANLzJ76t4FUOB3YGSI47Hk+0QJm6He
	6gx/0e79VvAg7B1G
X-Google-Smtp-Source: AGHT+IGmlPlf7hPuoZfoUynZKjAb1C9EVkjuhhuVc0cdTY2nEaJ/tIrMel/mgXhdgGlrmCJKR82ViQ==
X-Received: by 2002:a17:90b:3944:b0:2ee:b4d4:78 with SMTP id 98e67ed59e1d1-2ef6ab1052amr8897289a91.24.1733548858076;
        Fri, 06 Dec 2024 21:20:58 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f95899sm4052365a91.12.2024.12.06.21.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 21:20:57 -0800 (PST)
Message-ID: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com>
Date: Sat, 7 Dec 2024 14:20:55 +0900
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zilin@seu.edu.cn, dhowells@redhat.com
Cc: jianhao.xu@seu.edu.cn, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev, mjguzik@gmail.com
References: <20241207021952.2978530-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241207021952.2978530-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC: Mateusz, who responded ZiLin's original question at:
  https://lore.kernel.org/ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc/ ]

On Sat,  7 Dec 2024 02:19:52 +0000, Zilin Guan wrote:
> The function netfs_unbuffered_write_iter_locked() in
> fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
> wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
> that ensures the flag update is visible before the function returns, the
> smp_rmb() provides no additional benefit and incurs unnecessary overhead.
> 
> This patch removes the redundant barrier to simplify and optimize the code.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  fs/netfs/direct_write.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 88f2adfab75e..173e8b5e6a93 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
>  		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
>  		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
>  			    TASK_UNINTERRUPTIBLE);
> -		smp_rmb(); /* Read error/transferred after RIP flag */
>  		ret = wreq->error;
>  		if (ret == 0) {
>  			ret = wreq->transferred;

You are removing a barrier which is deemed to be required by LKMM.
See section "SLEEP AND WAKE-UP FUNCTIONS" in Documentation/memory-barriers.txt.

Quoting relevant note below:

-----------------------------------------------------------------------------

[!] Note that the memory barriers implied by the sleeper and the waker do *not*
order multiple stores before the wake-up with respect to loads of those stored
values after the sleeper has called set_current_state().  For instance, if the
sleeper does:

	set_current_state(TASK_INTERRUPTIBLE);
	if (event_indicated)
		break;
	__set_current_state(TASK_RUNNING);
	do_something(my_data);

and the waker does:

	my_data = value;
	event_indicated = 1;
	wake_up(&event_wait_queue);

there's no guarantee that the change to event_indicated will be perceived by
the sleeper as coming after the change to my_data.  In such a circumstance, the
code on both sides must interpolate its own memory barriers between the
separate data accesses.  Thus the above sleeper ought to do:

	set_current_state(TASK_INTERRUPTIBLE);
	if (event_indicated) {
		smp_rmb();
		do_something(my_data);
	}

and the waker should do:

	my_data = value;
	smp_wmb();
	event_indicated = 1;
	wake_up(&event_wait_queue);

-----------------------------------------------------------------------------

Are you sure removing the smp_rmb() is realy the right thing to do?

        Thanks, Akira

> -- 
> 2.34.1


