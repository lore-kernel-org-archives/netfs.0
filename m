Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C684A36
	for <netfs@lists.linux.dev>; Mon, 23 Sep 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130050; cv=none; b=iyZnFdG0E2MNMK8SpbIJi6oU5tm/qQQ/Wn4T/h1fyqI9lKtYHnxHoY1826XaPtmAewSjPVovHr/VWX7DcStarrbTrnUbQ8O7ejUsuQfytdKf0xTba3996VPB3qVpcETOUHTMrMzRGAlxaFoiDDQVTSM8VuzqEwU1T6b3BapR7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130050; c=relaxed/simple;
	bh=I39zkW/kbT3Ufd9pmx9Uzp6ZFsPoalu4/LQvA0A1FO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMgBij/E1W6SzQ7XilNLC01ywn5ghUpg0S6JozoS2djRaGhHUVfyvzM0k1vEt97XGFkgPZr847juhn0StmHvBauDdHa61r0R36auMSOoqaSXYOaZzL15xZ5viZlRWhGw0d+vTM2n7TUUkf/EoGce4YJCRMYa/EEItCI9Crjzd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG1RZlDh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1RZlDh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53654dbde59so5461894e87.1
        for <netfs@lists.linux.dev>; Mon, 23 Sep 2024 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727130047; x=1727734847; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNMtJL71ZDx/2MpgXo8xbuzvbC5cBg0WyIL0f1AlPoU=;
        b=jG1RZlDhqzK9SJHPSDp/eZROhN/V6yR/00P3m4cGS94Vz9BJ6OTisPd7ZPGkZQEmXW
         Huknotzhv1UUMOSgKGZuy8LXFAnCNAMwtulcNFyOq1EptTGmg7Zfow4p6chjzsUcg9Td
         x7t1opFyNF9RwTMYHCekCCvk4BNXJNQGTiPSRkyh3RU4aZ6TnAe1CqSF+iWnKnVVvDyG
         UNfDh9VB5QZT3vswH+l/PTFJp5NeXJ5pFMIFVqr9dcCHiWhfP9Z1vF2QprTAZXdZQnoA
         zstHPdG9r0K2z4Zglz9d82c5Z+t8O86EYvfqFTdh8Ze6opW8ZtoGB9edtLZQEQC/yTSQ
         ovew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727130047; x=1727734847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNMtJL71ZDx/2MpgXo8xbuzvbC5cBg0WyIL0f1AlPoU=;
        b=v/XELJl/d4tJypplGCN+D6w47ndK50NMGIGDBOpDLYSg69Ow29eX8bKeLYWYEikbKt
         l/NX8GILJvWDSeArFx3Ge+V7AG5oAyUGsiDFVU2zcYbxbqxNBMmjziXmBTcbKGdeqKJC
         /et8gEteuXqc8R9FmvpV2xANk62HekmW6/+oY8mVOT/oInj2fg6RQcc+t8lHaURyFmiU
         5+c0K2FBF2PF6KoOeZpE13Nonc2wmTcldDj9Muq2gLec5Vbltk5Lm3uSkR0+feH37TLG
         PCB6q0x1Vem5NRtnpL89qxtTV+xkxKkHxaRI6SH1fopvKYm9X8vPMiO0kGQLCLUowBJ+
         aTkw==
X-Forwarded-Encrypted: i=1; AJvYcCXV7xPv7QO24RIMtEy7UnWB4JEVkQVB0zBenOF41tS80sV9+ObADKcVCdew0rZVBTLmqPZKFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn6O6mrKrnJ9gw7m4YZSoqFJYEowSILJNt/rBXWqjUqjKOOlS4
	t9s5iAqQSd+zkcr8YOhBEF8pyDUWDGd4hyTpCxKp7/raI0KqQSkM6SWKVD8Td2bKcENxBfCnP7G
	spNKf/AA17KgKz8xW1GghQsWJetI=
X-Google-Smtp-Source: AGHT+IFSbGoovaCTItwXPKaGxT+vP85QVsKRZkmCJA5rZZuojl9Rce9M7PI4TZVkGutC62+PVBjxG313v9PS8/TSX14=
X-Received: by 2002:a05:6512:3510:b0:537:a82c:42ec with SMTP id
 2adb3069b0e04-537a82c44d1mr81547e87.4.1727130046730; Mon, 23 Sep 2024
 15:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2390624.1726687464@warthog.procyon.org.uk> <31d3465bbb306b7390dd7be15e174671@manguebit.com>
In-Reply-To: <31d3465bbb306b7390dd7be15e174671@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 17:20:35 -0500
Message-ID: <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Make the write_{enter,done,err} tracepoints display
 netfs info
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next since it is important as it fixes a
regression affecting cifs.ko

On Thu, Sep 19, 2024 at 11:01=E2=80=AFAM Paulo Alcantara <pc@manguebit.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Make the write RPC tracepoints use the same trace macro complexes as th=
e
> > read tracepoints and display the netfs request and subrequest IDs where
> > available (see commit 519be989717c "cifs: Add a tracepoint to track cre=
dits
> > involved in R/W requests").
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
> >  fs/smb/client/trace.h   |    6 +++---
> >  2 files changed, 18 insertions(+), 10 deletions(-)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
>


--=20
Thanks,

Steve
