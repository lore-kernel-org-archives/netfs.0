Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C413665A
	for <netfs@lists.linux.dev>; Sun,  8 Dec 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733653251; cv=none; b=LQ8Gd9GiOOVn9PSaPpRMjStvOQqEhgWN0O2SEan+mlAJQVPRNyTE+eStycr6vOHRcg7GwIvWFWH3h6vH7k0ow/q00xSwHVOBotzsmmX5Ggqgjw8r4jcl7sQ6MXsKsB+79XR9IAaNVlRNTwGVdAE7ltU+GT86NO+8iw8o9l5IiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733653251; c=relaxed/simple;
	bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNo6MeeqjmX13+AZchigtGuiHLXf3NSzw7ZEJcGwRH6GB00sTxG7LrZiIo3f2Ihyd6noNity1wD4OEGO0rS9n3dJ4rkB255pLXps7eKHMzPriG4iMHYDxnG/yxMRIBdwF1jw/21VZKp+Bs39R1BOANI09S2+Ncor6hJB0Yd7pzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SwiEHTMH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SwiEHTMH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67ac42819so44593366b.0
        for <netfs@lists.linux.dev>; Sun, 08 Dec 2024 02:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733653247; x=1734258047; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
        b=SwiEHTMHrsbghD2w0tR+Cah9DsKRYkVb9umr5Jr4UMnRsr3el2/6O2FSXwzulFHGSl
         hgoci626rSDGmpohmgOXIc3Qfg0w0M2yEWcUfwwr3ARKKWSfCC5JdaxOEKpyq4Wm8+7x
         zhBU/1FqMUF6vvOPn62WD1bTUCxJaZE8vQrRhLPdXuJ7kDesv80p48+crujnDHx1A2Qe
         91RUggFqD73FPexR574EuAezuEU6ffn0MiwZHENCU8fX85kUBpGtTdRTbhqwhbWbUexT
         ZVEHkBGlMA32OfeTfR7+TpN1iilaAyAtgjOE2Bxh1BnPJiCGp5u4a1omVDhtH9Ny9+gc
         U6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733653247; x=1734258047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
        b=hrz2Vd7e2/TKt78jOPyzVfAO1n1tkLR8cI1l81iJ1gffDs9DjdD/x1XMa1qikpj9bc
         4/x4kWMwjTnDc6rxGfkbl365D8yLxrpTmyJxfsCsuNpZwVoQbjjf3R5xUyeEh/BOTLNv
         x/agEhaK3YQWgceH+VXLVIZ2umWJJzdfSn050xT1nMtL6VL47M5T9iJHRhgsEQa5JVGF
         XXErxeHAy6cnGMEaZSoCoGbUv0/uI8AA7qGGQi/wNfKN4ukA25C28/Qf2//D5acmZ/Nh
         cNkHTWf7KwmCCZ+lQzycc4qPQeRKILX6Pdw83oiRgEpNdt2fdb/huugYS/0jmI9Sv947
         Q9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCZuDubMnZaNELQIkzP//crUMpRH9NcZcZpf8gWttJds6Yycdt+GAbnOd6peGh34jq8TwPeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3QUVMeDZqeYLmwrq52RLH0iyWl+9PVETOreQhJu2aeC2wkS6i
	xgTsvlK+3UlJ1u3yxVtnPgFkR9LLvtEzalT/Z7UcbGtLDG7/0ZbCeeQFLXEwwGRZoO+EL4to7oF
	IierM8Piy+S+wrRy9K2Eacf5y5azfTr16TrraTA==
X-Gm-Gg: ASbGnctD0pYiF8qf8iLwFcUhDst5zKTVEXbVyAjUDJsZHJJPGvhUfCD0/vm8T1g31ty
	da/xTWTienZLkK7VyeAv8IkLsnDu20ZhqtjeYVPlQSCsxhb+HAXPUdssasVIq
X-Google-Smtp-Source: AGHT+IHhsFb/p+bUKWhNb26BKnfksM/ayxxLkaw2zAoftdh79YIZEReweI5txI3aE/Mh13JN6jNXf17waG7w8+NuFdE=
X-Received: by 2002:a17:907:3455:b0:aa6:3b8e:e07c with SMTP id
 a640c23a62f3a-aa63b8fbfa6mr604208266b.54.1733653247478; Sun, 08 Dec 2024
 02:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
In-Reply-To: <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sun, 8 Dec 2024 11:20:36 +0100
Message-ID: <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 7:39=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> Here's a Brotli-compressed trace (of 6.12.3 +
> dhowells/netfs-writeback). I can reproduce it this way:
>
> 1. log in via SSH (cm4all-lukko is our SSH server)
> 2. "cp" a file on the Ceph home directory
> 3. log out - bash hangs inside write():

Today, I took the time to bisect it, and the bisect arrived at
first-bad commit 796a4049640b54cb1daf9e7fe543292c5ca02c74 ("netfs: In
readahead, put the folio refs as soon extracted").
