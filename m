Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B118E368
	for <netfs@lists.linux.dev>; Wed,  4 Dec 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300856; cv=none; b=ZQvLCbjRFv0NRWFLVAODZysEMxJfPuI32l099XHK/05rI9Boweqo82GS96Y8rcV67CusMaPzjdlWxabaQWdOxIuX3dQcC7kR2M4pXYp+TUxpUa9TD+5BfuiPdKSBbCBMAciFWaWwaxdGybAit8oltPMBbMyj/XYde3N7Fbx5e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300856; c=relaxed/simple;
	bh=ucfBwFNm0ABhHUXqA9vCNAbh5NsOj2dYkGl7XgX6DzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAXzvWQAT52bbwU3octDhNaAL5NJBklHIQb+LG3+OJ/t8Ff6+adKas+yz8vGxxokbYP3sbs0Zwwlt2on8G4wjN2/DYv6dtyJ+pqrOn0mnp3zy/g7SLfsWyZrOt5IpikF4y8WFFCuCOX9WEtDVcGCLLTNPmBn1CpF+/ER/k59ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZfXlHyA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZfXlHyA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9e44654ae3so851518166b.1
        for <netfs@lists.linux.dev>; Wed, 04 Dec 2024 00:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733300853; x=1733905653; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yzShrViHPdCPjMWdlFTiNS/QjPXPWPOzuyMGv4WSxU=;
        b=mZfXlHyAsCpfA1v2wfjr0hSOgCtwdoGUlZ5Wt8mDtOB7YZd1wbh2bekgaw7yQHUwR+
         LH4452UrMkwEgsuzP3kfExY9MorhPsqgr4Ycz99dRaq4A3YW82lpj+vygSEE3kctdVVz
         vXotEHAKw1bNXxDLr6pw4JiGG18ZdQt0dX4M47PaMygHqZ0ZQ8EULm15CMjgopvN15qN
         TudkaBr3CPJ1X98Fc6txp8f6dZmpEUGInDyQ9rnn2njNfZKqY26moPuO8oseauyudB2U
         joXQuH0XIK0G7DpqnStDZ8a4lAsyNUCHXN96LnNV55ez64W1q6S3o4CmH3+JN5WE0n/x
         WBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300853; x=1733905653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yzShrViHPdCPjMWdlFTiNS/QjPXPWPOzuyMGv4WSxU=;
        b=t3A/EIanusuIdkhy4hRXe+llnJAvmtwoUdF9EPDitg3J+UkMlHCY+2mrjOyXWO8e4f
         lwmXM40XJczbZMKBDhq/W6zm1r6Mi2rWJxRNO4cOGiqsYEX9n5ARsA2N8L/bVP2LfbrM
         r8azzfbDfZqLu+wwMAhf5pJ0qUkG0ckYaBO9APKt3OId/kaAu1aOXhMy4HKGhlAVY8XK
         XxuA+rKhxrN/2fZtlNjlCz2gaYWz/bWgGqz2mL449ifPKX9q6IUlj2j/58euQrFjRqEB
         9A/A83Pr+GGzqmORznG/Xo/ADM1oPd+TcxylOqmFlrxWH/YOBQ70J/elU56Fxp8QddCi
         VMNg==
X-Forwarded-Encrypted: i=1; AJvYcCXVjgxT5b4JayHxPMto021oF0tWJqI9LO31wOmIZCbNDTN80VK9mhb/zvKt3SIhpUfiNbGopA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyML9bh+jG6Gj5yC8csNDXI2fkPWkm8kN+urQhbxWo+a7I4CKJY
	duhfaKlimfWESpMiuq9Eu1Z0oTdHnyTpcgdVkvn/zVDfViQx3Q/5
X-Gm-Gg: ASbGncvnmF2HN+q3f+sCjWCKPBBCIfrGtyoKgXi5lOrTYJ6ZcYdzsGQW26LhqW6lety
	LWhFUeKKNhiX3XTK5WMALqE/eHo/elD54zKLQQZiBZzbWKCMFen0XbNoir0W7GYh0eBb6/Y4UjY
	ptAWOLM8FG/8r5utxIakcU6wczM5kJhPOXXGfpDpz4ulml0ORJpqRtWuXG7HR6h9G/tFGOw1trE
	67oyRS77FyPvZloBi3r5OnUQRNK3W9HPLSun6T+T6ANfynDnmi/4lRVcM/6
X-Google-Smtp-Source: AGHT+IEo+659fUpkUFFkpxGn3gIqjDDx/wXNSC5AVajmYgifn/7dCNbegBe0YK6GdEfvUasEaSSYhA==
X-Received: by 2002:a17:907:6eab:b0:a9a:3e33:8d9e with SMTP id a640c23a62f3a-aa5f7dab9d4mr596771966b.28.1733300852808;
        Wed, 04 Dec 2024 00:27:32 -0800 (PST)
Received: from f (cst-prg-22-5.cust.vodafone.cz. [46.135.22.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6f99sm704374666b.131.2024.12.04.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:27:32 -0800 (PST)
Date: Wed, 4 Dec 2024 09:27:22 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, xujianhao01@gmail.com
Subject: Re: [QUESTION] inconsistent use of smp_mb()
Message-ID: <ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc>
References: <20241204064818.2760263-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204064818.2760263-1-zilin@seu.edu.cn>

On Wed, Dec 04, 2024 at 06:48:18AM +0000, Zilin Guan wrote:
> Hello,
> 
> I have a question regarding the use of smp_rmb() to enforce 
> memory ordering in two related functions.
> 
> In the function netfs_unbuffered_write_iter_locked() from the file 
> fs/netfs/direct_write.c, smp_rmb() is explicitly used after the 
> wait_on_bit() call to ensure that the error and transferred fields are 
> read in the correct order following the NETFS_RREQ_IN_PROGRESS flag:
> 
> 105	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> 106		    TASK_UNINTERRUPTIBLE);
> 107	smp_rmb(); /* Read error/transferred after RIP flag */
> 108	ret = wreq->error;
> 109	if (ret == 0) {
> 110		ret = wreq->transferred;
> 111		iocb->ki_pos += ret;
> 112	}
> 
> However, in the function netfs_end_writethrough() from the file 
> fs/netfs/write_issue.c, there is no such use of smp_rmb() after 
> the corresponding wait_on_bit() call, despite accessing the same filed 
> of wreq->error and relying on the same NETFS_RREQ_IN_PROGRESS flag:
> 
> 681	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS, 
> 		    TASK_UNINTERRUPTIBLE);
> 682	ret = wreq->error;
> 
> My question is why does the first function require a CPU memory barrier 
> smp_rmb() to enforce ordering, whereas the second function does not?

The fence is redundant.

Per the comment in wait_on_bit:
 * Returned value will be zero if the bit was cleared in which case the
 * call has ACQUIRE semantics, or %-EINTR if the process received a
 * signal and the mode permitted wake up on that signal.

Since both sites pass TASK_UNINTERRUPTIBLE this will only ever return
after the bit is sorted out, already providing the needed fence.
