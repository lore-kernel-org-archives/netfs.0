Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C31E9B27
	for <netfs@lists.linux.dev>; Tue,  7 Jan 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248528; cv=none; b=OdGFfKdcxoLJQafjzadOehqBnSt/MbLxv1lRB2wjddWjfjtDS5ZnSTO/U6g84EAZj57Aqg1xnYvt60QCOWgWr/ZP+oxaiO8rAJN50COVR51ByjNraf0lSLT2YRKm6sCPr/Ok1uqxfVQZtgGiZ21N7wJSTOJAHSZ5LoSJiq+wKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248528; c=relaxed/simple;
	bh=QZp/WDXgrKvYb74JicBCfyng7OGqeKkWShWpr+oWPc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAqgISaYggi9qCVTczegxf8/7jkkh++Sl2DM0edgC9/V7HWs1Ld90q5E1zdjKHRyaRbFMdQEAT24Y0ntaCgYOe9tGJOjXvOTmzXxrNSnBdZingQrQgGw9dQbqTxHj0/pDsnLzQekACqfxQcMgVbUSiI0zOX+LwC6xt/sKNBgV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Prj+Y1wb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Prj+Y1wb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso224429066b.2
        for <netfs@lists.linux.dev>; Tue, 07 Jan 2025 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736248522; x=1736853322; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4sAEv5+P24ZuVYwXpR4YI7dfuop0huoLVLWvKazLDA=;
        b=Prj+Y1wbftKt5bFM2I4wq99dZXkvkUS9bVPTmE2783L0Mk84Qntsy++ylrv1LwxAdp
         LNZMGQGAiSNObyJ2251ucLl2tsixzQ7fAgNuqJRh6U/e0mNGnRJSxZsGi/FQXP0YjLxe
         1eyhNECIf0N7HdtNWwNkxub6lF6EClxDa4WCj3FAuNr5w3ObMOmrZJaOvRJcswLtNDkm
         II5gUX/nvDGKh7OVQrmgIAZpao8RSS9qQoSMTcxyLtDxv45VS+Q0ElOHy6qfNkKJNpWB
         Nd2r+oOC3SDz+Y9W8fqyUw7Yi1sZLMqb1L6Vx7UZwjLsGqxZSNBWV/6DPddHTXnukIMJ
         /xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248522; x=1736853322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4sAEv5+P24ZuVYwXpR4YI7dfuop0huoLVLWvKazLDA=;
        b=KaSOQncxJRCOBmltjt68OGHNpQIMK99gYGd7lylQplB1C+WJ6NlScX2/bV+WUEaxSU
         LJDND2aKTblz/UqVOF7rPU7Fq6SjtUG+Jm9TJg+nj9mJA8e76dOUKhh+eRHGvzp++JsI
         wE75yypF+AoMQfmHtuJpaPWgHRiAIInoTn9SPAaDxu/3bxmZLpzR6ds2Em9ZEyZLeoQi
         uhmWr1mzTU5nWXJmjrsF3jLTq9KdMdaz4ZuH8ZRYx7bIgjcZwvSiTBKAs27Aqu6pkhIk
         IJiX1ofCr0V37o/JTKzkNDHdoBKfkYPFrQXN3kFVoPFQbcOcpAEpm2S6i7s0rPK4dLG3
         Vlug==
X-Gm-Message-State: AOJu0YyDJNx6AI1hPuz6/I1l/Y4Fykijl1f5A1QwuSmXti3x3sW9SiMs
	1KKzHV+2Y+iHQCY8AEBU8zdaPc1sqIXRGPAjxHIbh03FabESecUziQMEaXcCwVE8wKMsZkWA353
	18wQASH9XYaUCl8RE12xw/khmX3k8Vr2+7dsFnErqpQ6DQaXDmIk=
X-Gm-Gg: ASbGncsyAlXyCUm6MZmrdKmRT6IheqcXtqolGiVPP7OCNusgV2VaNlJJqq8uqnah7oj
	JbXSfdPPBYaeCPLBlIQ0yaZJOAyZLYAPW0of/o0Kbna67pVBzmTJGS4VMxmkQRbSvf0I=
X-Google-Smtp-Source: AGHT+IF4CUaVr277Bgf4TPhx5v7M8trrJ5YFFhkQe+5vif2wVEaqEOTKmXfVNKJLrK1OS6Px9dwjOxAnfnP9Jm328t0=
X-Received: by 2002:a17:907:1c91:b0:aa6:5d30:d976 with SMTP id
 a640c23a62f3a-aac270278edmr6088067366b.10.1736248522097; Tue, 07 Jan 2025
 03:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_JUNO5EZosu00H=tZsgfCAzQkBBkJjVfOHYrX_6mHEPQ@mail.gmail.com>
 <4022108.1732899245@warthog.procyon.org.uk> <CAKPOu+_gzJCN6OKYvUw+H9kDrc3YG8yxJS_YDx41zS==wBKpbA@mail.gmail.com>
In-Reply-To: <CAKPOu+_gzJCN6OKYvUw+H9kDrc3YG8yxJS_YDx41zS==wBKpbA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 7 Jan 2025 12:15:11 +0100
Message-ID: <CAKPOu+8qbUWCeUvb3eMfkvF6hx8pGWf+o8sU6T3dPSmWr+mXCw@mail.gmail.com>
Subject: Re: New cachefilesd implementation
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:06=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Fri, Nov 29, 2024 at 5:54=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> > Now, would you be able to clone this:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/cachef=
ilesd.git/
> >
> > Then rip out the existing code and put in your code?  There's some stuf=
f in
> > there that is necessary to run on SELinux-based systems and it would ma=
ke it
> > a lot easier for me just to replace the current cachefilesd package by =
just
> > pulling yours directly.
>
> Here:
>
> https://github.com/CM4all/cash/tree/cachefilesd2
>
> Please check if that's how you envisioned it. License is also changed
> to BSD2 or GPL2+.
> RFC! - it's not yet finalized, and not yet ready for merging.

David, please don't forget this.

Today, I have merged our latest version (0.3 -> 0.5) into the
"cachefilesd2" branch. The new version limits the io_uring
concurrency, because previously, our daemon could lock up the kernel
inside io_uring for exceeding the cgroup memory limit.

Max
