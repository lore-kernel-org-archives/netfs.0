Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E37226D0F
	for <netfs@lists.linux.dev>; Fri,  7 Mar 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363776; cv=none; b=VAxlt2js2pEaKJr8fwoRTyMfLquDj3av8yz0BSnOZnnbKBps44RPC7ADWJzEQ7aC7Veh9h4+vlVAmHAStcND1X0ZoyRFuV7Z0dfp5Tka2F2UWPbuN/JLXSlH7iAQgdUYQO6Ot1MuUSyis+oDp+qs4rwYxHZ5HpG9QJSD6d8/4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363776; c=relaxed/simple;
	bh=vJ+jf3Jx0DsxFUkCZwqaWfUCJ9ZSvn+hNc14SICc9g8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fLzopKC8FUJ8P7i5NjkR3RdTiMUwY2pCTaxuFpDZTIdvJTPsROUITYHxW8IpE1V9gB2XXQuL4pTTNRjyxh0qrC2wvs3vf/yD+WnBnRDabrpJYRL2vItEffj/T7E7eIdxSKzptlEfZrepafMRxIiMKwP/NUDdv5sgRR/CEeA5qfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idGpNztI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idGpNztI"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bee1cb370so15632651fa.1
        for <netfs@lists.linux.dev>; Fri, 07 Mar 2025 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363773; x=1741968573; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y2wGs5UXG2ODNyJagCD7ka8U4DqPW7/dd5bx6dOjGVc=;
        b=idGpNztIbUOCN/ZVc3J2iVhj+gNe8M5KO4dsgeEgCu3+q7UfjJ6gQmxvHsP38/p5p3
         SZo2HITDp9Lx1OGsyi/CKoaprdsUNZdd5Q96OVT0GKd0QbxMGqI3mV4tl9m75INPhbzg
         Jl/eKl8f3F+higsJB5s9oR+vzoXD9AORRcTYInL0GGNmhfFJXG00K8x1J0t4qqW2UzNO
         gzXtqG3MyqrutnIghNJ7CB/KlOJN6IFyPszO0Zv+4XmSUrurX2t0VIg1gMPMeDfjtiZS
         QxKjbUTL3InIZShGkwzmHZC+bb6oNc8LGBlFOqddw9yyqKp3wmwkzaBEsQWmJhQmvebA
         aQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363773; x=1741968573;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2wGs5UXG2ODNyJagCD7ka8U4DqPW7/dd5bx6dOjGVc=;
        b=wG9BE2fdW3n2DLY7e7y9tRAwpcThfGKYtw9IMc/7H29eXrPT7L+mT2t1iJKX1xIYwk
         +EfZ9LkV3LSpNI9TPLWJglTN+EqtK/yfC7ojcerPIGK1FdIwNgeR0nI8Q4ifMGxzk12Z
         mkMZVy2aq7cDPShC2XKVsOscA00WJY1qR30bou/WsHtKI+Nu5dsJnL6hGaoD04UzIxW4
         AQEQHad88QocGId35AZDlq3v5cN9f0MOvXllfGsV5kz3yKLhOWy0WbqvKYz+G5BYrZew
         HUBvULsg3eiGMw9LgaE28hRM4pqbaKil15TRAKSZ+su8h7EEpByof9gOJorvR1jDm063
         lx3g==
X-Forwarded-Encrypted: i=1; AJvYcCUD2RFzX9UZ4UHlfb7Hn0ySE+1uqd81b9pvE31kX4lX5g/iVy4eJGFhnBvc8wesH2nLR7xrPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqHhskzWPVGZ3GXoGMZB5/x+/JySI2Bk4cYl4EvJ8VXKwfNrcC
	MlwTqKDTjhkgRJWVOPw0xuHDuxqFxMDZFINIOcR6LlfWelTdPdkVpP0ilp91uMhmD0UEGF7Os1V
	cIWE2Hv4miSAtxnMd/1AHqFug3TQ=
X-Gm-Gg: ASbGncvqetNbGm04457xI5f8OrwJ0Tvl2X4jhP5u3Wdeeqq9zZJsTxYeDn87hB6yvZa
	79yg9bcMkz+riUHBN8mgYPOY2GSqeh6dYlWEy/5k3RP6HivN/srCh9Bs+L3BK1HfQ2Lw3j404ej
	porriVuEtWQpMY1yZBCd+NGWnNcwuQwWc7UZl9eywdXyDsvREsEoyd60DhD4my
X-Google-Smtp-Source: AGHT+IEGAo38UAEc4cQfuVmq5Jdsr88KuRMq/DhEusWgz0mo46DhAi2VuEH+tMH8CPg0BPgNIUeczUEJI+CaQB5LfZA=
X-Received: by 2002:a2e:99d3:0:b0:30b:f15f:1c02 with SMTP id
 38308e7fff4ca-30bf452c908mr14816111fa.18.1741363772920; Fri, 07 Mar 2025
 08:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 7 Mar 2025 17:09:21 +0100
X-Gm-Features: AQ5f1Jrwvs7RoPwaNoYn3qlQZNg0CL7a1KYAB6ll61sjH1XcH0LjlfcPMcIjohc
Message-ID: <CADYdroOnqNT4uWz=XAfr1iuaaLmWMzSyciXzFSoMP+CoxMPDpw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: max.kellermann@ionos.com
Cc: Salvatore Bonaccorso <carnil@debian.org>, dhowells@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I reproduced with the available versions in debian:

linux-image-6.12.12-amd64  6.12.12-1 -> segfault
linux-image-6.12.17-amd64  6.12.17-1 -> segfault
linux-image-6.13-amd64  6.13.5-1~exp1 -> 'kernel BUG at
fs/netfs/read_collect.c:316!'

Then I took the debian 6.12.17-1 kernel (latest LTS), added those 3 patches:

https://lore.kernel.org/netfs/20250211093432.3524035-1-max.kellermann@ionos.com/
https://lore.kernel.org/netfs/20250210223144.3481766-1-max.kellermann@ionos.com/
https://lore.kernel.org/netfs/20250210191118.3444416-1-max.kellermann@ionos.com/

The resulting kernel apparently fixed the issue, I just testet in Qemu
so far (no signed kernel for secure boot).

Tested-by: Norbert Lange <nolange79@gmail.com>
