Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AE172BCA
	for <netfs@lists.linux.dev>; Tue, 30 Apr 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489143; cv=none; b=amjQAYVj9CULqXmuHLZBvOyS5FQ7gnu1sVPr+47yCCiA1/oGZ7gjmwNStdAt/veVzWK3xKn8iR4CSH50oIQYXgZU9hegPki/TxzmDIiR1EmUTcTZ5e+yywn31pq3cPabE3jbFmQ69FyLNObjqOtCpURR/OEQy7oB+2uPJl6Qfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489143; c=relaxed/simple;
	bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFtfxmKH8TldDL0BgFAUPimB7v3h+Sgj19Wo/dvwtbv1tjxuFgbe7UVWOKCDmEMPGawKjVga1CDeqdsnUGt8DBElcDFIXk9dbU5paRKh4jSVHlu7t3/Ej6aZgjsr1OKIA8g9BHOz1EWJ6Kry/C3TWYkTMroiWps0iBdS4G6LwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsKJLxLQ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsKJLxLQ"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so66876891fa.2
        for <netfs@lists.linux.dev>; Tue, 30 Apr 2024 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489140; x=1715093940; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
        b=OsKJLxLQZQ0IR0gEMxLguMvimr/anE0ITKNzkhyuMSAtM6MWiZmL8/6LrDla0P4o1M
         M/RlEZ4XgqGxTShERWD5YU2dmsb5+nNOu4XI3Y4WtAxItTM8ttsqpttC01e09tCKVmrT
         +8b84oZQnM/znrYbiQNUaSYhFaUuPFF6GPfssEKN1UwpGcT+qdCA/7WT+4zDcU9QBCS6
         Erer1b9yyHfyaZ+Xh9HAPZESRLzsEgb2I4iAClhTA136/har1pV9OF4uv8dXV+dveq5P
         NIybgNjdwfklpfMd2SZH7dPMRqR3F31MIAMMBu3sI4tKxeIervZH2S4Rj2NSw0zmb165
         w+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489140; x=1715093940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
        b=H6q8MaRq2CfpkVBjxHoFMckhm1ljzVJgLQAvixdqZJjyetfZ9H6Z/MNXyACo5ecfdn
         7eWak20CV2gbQvm37fbBs1kzu5QqqiF0kkZaImlDuoNgqUI2mvnLjKCMtwyPjnVTKYzs
         hvPBmMuqHLwrSA8ahwVoDRPMgz+IS8Zg4PkdbcXtCqWLiUBbtr6ARcBqrJ15rsi/P/8o
         Dg7L2moCqueNXU/7OZLzor5/38iJHr23FF4vL+cxQWzAISoNUWHiXOq1pEQtkBGUrDK6
         CKXPorwVqcYqLXpdSH4dauE2sw9vRC75TcNxCpwGjnx/ypC7rBy+Kox65SFCfinsJTc/
         LdqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ckWu9tlHDrqLk/364csnpKcHbbS9l1HFXNYZiQK9myHGLZGCp+3M2lS3KgwiHz1hA8LJ/b0FLSlakzfNveYDw3oGstQ=
X-Gm-Message-State: AOJu0Yy5pqK9u4ulBJxVCdBOkLpN5+VCHHZz/qPgXY5MeLRpjlEVZy/o
	P6ULHe7ryJXsIbBM/eQ3HHPErh3qlYubzxEP/y571ZRd7pcC5ORoosM0W9gqfJ0zWPAtDHUFl3T
	4f6mlnz/471ziGqCGitWBqiawHbRRNA==
X-Google-Smtp-Source: AGHT+IH1ix0BqVq9FIQTiQZX/OFdgb0zFuvm/XZ1HQbS+UYTDWVWBCztGEQwH9uF9Er2JGQROqanY7i0WYIkpAAzanE=
X-Received: by 2002:a2e:7a0a:0:b0:2d8:45ff:d606 with SMTP id
 v10-20020a2e7a0a000000b002d845ffd606mr7232211ljc.50.1714489139376; Tue, 30
 Apr 2024 07:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240430140930.262762-1-dhowells@redhat.com> <264960.1714488463@warthog.procyon.org.uk>
In-Reply-To: <264960.1714488463@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Tue, 30 Apr 2024 09:58:47 -0500
Message-ID: <CAH2r5mspax98XVdEyYaupSFqh=M5zjcwckjta8H9=e+N-dnrmA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] netfs, cifs: Delegate high-level I/O to netfslib
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, netfs@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - I think it is easier for now if Christian picks up the series in
his tree due to the VFS dependencies - if we start hitting merge
conflicts with my tree later we can consider changing that.

On Tue, Apr 30, 2024 at 9:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Christian,
>
> With Steve's agreement, could you pick this set of patches up also?
>
> Thanks,
> David
>


--=20
Thanks,

Steve
